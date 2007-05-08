From: "Chris Riddoch" <riddochc@gmail.com>
Subject: Re: gitweb css - pixels?!
Date: Mon, 7 May 2007 22:43:58 -0600
Message-ID: <6efbd9b70705072143q46380a34v4cb55e803d164680@mail.gmail.com>
References: <6efbd9b70705071613p23017509qaf9af12c1d14f9cb@mail.gmail.com>
	 <20070508012351.GB12978@lifeintegrity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 06:44:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlHYi-0001Q4-KX
	for gcvg-git@gmane.org; Tue, 08 May 2007 06:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967801AbXEHEoA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 00:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967811AbXEHEoA
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 00:44:00 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:8689 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967810AbXEHEn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 00:43:59 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1841508nzf
        for <git@vger.kernel.org>; Mon, 07 May 2007 21:43:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eOzd0TqmQiHy488siU59BZEc/dsiegux2xqesK4sXC5nddac/uTkUiWNYRakOE6yOKOZJOLzpUiBuCC5ypPuDaQmS4/n+iSa1OgGZFEPOzGF3HzZkypb7n/oORa0QtZiOAY4qrK76h/5wUxE69dTRaLlV8Vk+XLWWTShSXL/x6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WMlLMmCoGnBZlmKV3Atgcd7EcUK03SYnXHXxVflb/qpttgWfMBcxctWtY5O5C7kbqIuW6mRo0MM1rb9QfQ06YrWIBAU/epJO5A8SLJvIxjPfDydCbxY7b8rHORCE57KCk+wGe/EJgyPGWtjvdvCRYuexF6eG1DlV89vyOcMYd/I=
Received: by 10.114.26.1 with SMTP id 1mr2445336waz.1178599438860;
        Mon, 07 May 2007 21:43:58 -0700 (PDT)
Received: by 10.115.22.19 with HTTP; Mon, 7 May 2007 21:43:58 -0700 (PDT)
In-Reply-To: <20070508012351.GB12978@lifeintegrity.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46536>

On 5/7/07, Allan Wind <allan_wind@lifeintegrity.com> wrote:
> On 2007-05-07T17:13:42-0600, Chris Riddoch wrote:
> > I noticed myself squinting, on my 1400x1050 laptop screen, at the 10
> > and 12-*pixel* font settings gitweb's CSS specifies before thinking to
> > myself that I should bring this to the list's attention.
>
> ctrl-+ (ctrl plus possible a couple of times) fixes that if you are
> using a browser from the Mozilla Foundation.  It was perfectly readable
> for me, but I fortunate enough to have a large LCD.

Yes, I'm aware of that feature.  Very handy.  And entirely too necessary.

Seriously, this isn't something to push on to users.  Entirely too
many websites don't follow sensible accessibility standards; shouldn't
gitweb be fixed?

-- 
epistemological humility
  Chris Riddoch
