From: "Chris Ortman" <chrisortman@gmail.com>
Subject: Re: [FEATURE REQUEST] git-svn format-patch
Date: Tue, 15 Jan 2008 10:23:00 -0600
Message-ID: <c0f2d4110801150823u7899e6dds1192b5f3bb3f7133@mail.gmail.com>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>
	 <alpine.DEB.1.00.0801151444180.5289@eeepc-johanness>
	 <c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com>
	 <alpine.DEB.1.00.0801151612470.5289@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 15 17:23:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEoZZ-0002nv-Q7
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 17:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbYAOQXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 11:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbYAOQXE
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 11:23:04 -0500
Received: from nz-out-0506.google.com ([64.233.162.232]:29710 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbYAOQXC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 11:23:02 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1285596nze.1
        for <git@vger.kernel.org>; Tue, 15 Jan 2008 08:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=V+wGwjjLpz4tytYqVlK9CzSiCO6VRipwMkRxNIlzGV0=;
        b=ulw8UUkHwGuhdNF73qdIBGKxBmKFhluMErqWa9w5bv3Ms69oURPsKpt1n421+16WI6S4b8rF5RUSxgB7hqPclIJBpMdrxYGp+QiHYGsmGRfmigngW2YAWiQe+qfzM40dZXleS7pm8fCSS7qHvMYGQeAjT8Nl1WPfr1/jKngnwXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DW/sOR1nhIMr0fwl0kuEF6DEWYLV88wZiI0Ixx28SBA6T7B3QvKVL/KbSmnbM64bvlciSSIrf96xJJlUbyYQ7b/doSeTPxGJW1Lc/+SYSmnq5V3WSKb2fFDMimIlfmSVBkk5GJIrTJmEHYtCRGhhIryc2NuerEabs4JuiT5ZN9c=
Received: by 10.114.150.1 with SMTP id x1mr5608396wad.145.1200414180795;
        Tue, 15 Jan 2008 08:23:00 -0800 (PST)
Received: by 10.115.17.6 with HTTP; Tue, 15 Jan 2008 08:23:00 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0801151612470.5289@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70530>

Sure, but I will probably need some guidance.

Are you thinking to just create the standard patch but then regex
replace the necessary lines or something different?

Thanks
