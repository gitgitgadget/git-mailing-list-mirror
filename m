From: Junio C Hamano <gitster@pobox.com>
Subject: Pls Support Conservancy: https://sfconservancy.org/supporter/
Date: Tue, 22 Dec 2015 08:02:25 -0800
Message-ID: <xmqqpoxyeajy.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 22 17:02:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBPOh-0004w1-HL
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 17:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630AbbLVQCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 11:02:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64301 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753506AbbLVQCd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 11:02:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A5AA933317;
	Tue, 22 Dec 2015 11:02:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=H
	rvuNJKq6doH81RgKG4Symra/oY=; b=b7mzu1UX36N6kssq8ak4/l1WDwp1v4LWB
	yEYTSoGJBj3G6v8OgNAUPLmETRCqenUuPjFaZVtwkxXBGLvoP5jGJElJbnLxEMsi
	2UOHhxEjtu14F97WNynB6J3OXij0x93nGDz03R0SvEEGFFt8+UXLhy6EZ0qqyN2m
	WdiXfcZ204=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=SSD
	RQoPjmW/ZWyD1zmSvVrrkQKlQIXBOvEMehZgllqoKt+K/XmMNRJuSTqemWBcyp0X
	5P0vBg1UJYkjmYuMawRXUeuZCNI9Z50Sr0Cn86K7SCF/LUUCiZnZOXCzlXzf0+V5
	Y0tvAMAHAloaFacNitetXeMP3goCAh8r56aSTgww=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9DA4B33316;
	Tue, 22 Dec 2015 11:02:27 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1E46E33315;
	Tue, 22 Dec 2015 11:02:27 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 659B17B0-A8C5-11E5-95A1-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282881>

[Jeff King, Shawn Pearce and myself represent the Git project to the
Conservancy, and here is a request for help from us.]

We apologize that we're interrupting the usual content on this
mailing list with a fundraising message, but the non-profit home of
the Git project, Software Freedom Conservancy, is in urgent need of
your immediate support: https://sfconservancy.org/supporter/

Git receives a myriad of important services (see
https://sfconservancy.org/members/services/ ) from Conservancy.  We
have relied on Conservancy since 2009 to provide them, and we ask
that you support them.  While Git gladly contributes 10% of our
project's gross revenue to Conservancy's general fund, (while
Conservancy maintains and administers the other 90% in collaboration
with us to advance the Git project), that 10% of contributions from
all Conservancy's member projects doesn't add up to enough to even
employ one full time person, let alone the already overworked staff
of three that Conservancy has.

Conservancy's fundraiser, found at https://sfconservancy.org/supporter/
, is centered around asking individuals who care about the work that
Conservancy does to donate $120/year, or just $10/month, to support the
organization.  Conservancy seeks about 2,500 Supporters to continue its
current work, and 750 Supporters to continue a "bare minimum" of
services to its projects.

Here are some of the things that Conservancy does for Git that are in
the "bare minimum" category:

 * Handle our Google Summer of Code payments and travel, including
   handling all financial transactions with Google to receive and then
   disperse the money.

 * Coordinating travel reimbursements for Git contributors to attend
   conferences.

 * Buying and shipping hardware to Git volunteer contributors who need
   it.

 * Keeping the non-profit status for us so that we don't have to form
   our own org and file our own paperwork.

Here are some of the services Git has received in the wider category:

 * Dealing with questions from the community about the DCO and legal
   issues surrounding contributions to the Git project.

 * Discussing the issue of copyright governance and contributions with
   large corporations who want their employees to contribute to Git
   but need legal assurances or have questions relating to Git's
   license or contribution policies.

 * Helping us write the Git trademark policy:
   https://git-scm.com/trademark , registering the trademark, and
   enforcing the trademark when we need it.  This assures Git users can
   know that when they see something called "Git", it relates to the Git
   project in some way.
 
 * And, in fact, we do very occasionally find companies violating the
   GPL on Git, and Conservancy has helped us out with that.


As you can see, Git really relies on the important work of Conservancy,
and thus the Git project leadership encourages you to choose Conservancy
as one of your charitable gifts this holiday season.  (Conservancy is a
501(c)(3) charity incorporated in New York, and donations are typically
deductible on U.S. taxes.)

Please visit: https://sfconservancy.org/supporter/
