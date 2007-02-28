From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Better icon for qgit
Date: Wed, 28 Feb 2007 08:26:20 +0100
Message-ID: <e5bfff550702272326r7e2479a6ldd365f9f153a40a9@mail.gmail.com>
References: <1172279202.19767.12.camel@dv>
	 <e5bfff550702232247k447cf33asc47db99165eb7e4d@mail.gmail.com>
	 <1172559445.19312.15.camel@dv>
	 <20070227093534.GB13149@strauss.suse.de> <1172621880.3291.37.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Bernhard Walle" <bwalle@suse.de>, git@vger.kernel.org
To: "Pavel Roskin" <proski@gnu.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 08:26:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMJCx-000450-3z
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 08:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbXB1H0g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 02:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbXB1H0g
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 02:26:36 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:32038 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbXB1H0f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 02:26:35 -0500
Received: by ug-out-1314.google.com with SMTP id 44so45612uga
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 23:26:34 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YztVWscqXRHIO0kVjNURhLaFgkv+wztQaEFFq/avbr9vNP8fCQ0oVM116cKzwhrUu7aVmZ0HVtx07PWADT+9E6D3jBKKlsk0hAKB4J5NcQ3/+ZrvQx5DrMWcZYgyYXqTMePupyGRq/eNi5UbrJOmX55tPy2nwZDSWu3YGKP3A2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BQdVQNDCWDCRUsdVB6Sy4mmhR/brxlFbOSgou8PugZdE+doPjh7vBZkaDryPUa9ZqaG4s9xPcAZJtV1lLw4Qo59uuf+5apRwAGivHUAkWxSHqAY4YUi+B3XUF/1THo+/2f3xyyIXhRfoyV4+NNXgfVVzkW3muvII5Gj3EGZxlMo=
Received: by 10.114.208.8 with SMTP id f8mr2862402wag.1172647580178;
        Tue, 27 Feb 2007 23:26:20 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Tue, 27 Feb 2007 23:26:20 -0800 (PST)
In-Reply-To: <1172621880.3291.37.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40903>

On 2/28/07, Pavel Roskin <proski@gnu.org> wrote:
>
> * The gradients are improved to be noticeable along the lines, not just
> in the squares.
> * Saturation is reduced to make the icon easier on the eye.
> * The actual qgit colors are used (black, red, green).  Blue is avoided
> as it may be hard to distinguish on the title bar.
> * The top and left borders are made white to improve 3D effect and
> counteract apparent widening of the black line on white background.
>
Thanks Pavel,

  I have applied and pushed your very nice icon to both qgit and qgit4


Marco
