class OrganisationPresenter < BasePresenter
  presents :organisation

  def name
    organisation.name
  end

  def phone
    organisation.phone
  end

  def email
    return nil unless organisation.email
    h.mail_to organisation.email
  end

  def website
    return nil unless organisation.website
    h.link_to organisation.website, organisation.website, target: '_blank'
  end

  def address
    @address ||= h.raw organisation.address
  end

  def postcode
    @postcode ||= organisation.postcode
  end

  def postcode_link
    return nil if postcode.blank?
    h.link_to postcode, "https://www.google.co.uk/maps/place/#{ postcode.tr(' ', '+') }"
  end

  def has_address?
    address.present? && postcode.present?
  end
end
