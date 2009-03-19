From: Pat Notz <patnotz@gmail.com>
Subject: Re: Gnome chose Git
Date: Thu, 19 Mar 2009 09:50:39 -0600
Message-ID: <1cd1989b0903190850p1a08991y754904e7799c7879@mail.gmail.com>
References: <877i2lbvt7.fsf@iki.fi> <49C249B9.7010001@drmicha.warpmail.net>
	 <1cd1989b0903190643p19a40718yc4fd2730aab0a9a0@mail.gmail.com>
	 <49C24D9B.1060301@drmicha.warpmail.net>
	 <1cd1989b0903190701uac4602dl1d2c3cace45a9938@mail.gmail.com>
	 <20090319151610.GO23521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 16:52:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkKXm-0001DR-6j
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 16:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbZCSPup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 11:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbZCSPuo
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 11:50:44 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:6215 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbZCSPun (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 11:50:43 -0400
Received: by yw-out-2324.google.com with SMTP id 5so569584ywb.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 08:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XDkLW9I24ad9dCGvOF6B8F4gDqZ0pekFscWnGUNGj2k=;
        b=Ntcp0h1XFM64OlJnj/+hgkA4QnnDEmq9sxewbMgNx4i9bKzTy6o5+NudCwcuMixWeV
         ypbGwFP69A30EN/r10G6eKL/0rbDdmKE1Wzu7VMuRlfBSYefSKDx8mlm2TUr8du1h2Dr
         eTIu683xliunOI5hPxV+uQ0diYhHAR4z0AEEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=n4KS30QNVvpTt1Ud8iOR8RPNaUoXqBwKEUStvDa248Sxk7lUoq1GA+zagtWucI1msx
         XQkArKsdrixuBhvdb+R3IqLGsOsLW1KrHh6CcXlxkweOmexkZcbJ2y3RQIDFm4X8wvFH
         5ufmmGqYo+jyl0xemgQ3kqCKYC9SFTE1Rnw9M=
Received: by 10.100.135.16 with SMTP id i16mr2886865and.99.1237477839943; Thu, 
	19 Mar 2009 08:50:39 -0700 (PDT)
In-Reply-To: <20090319151610.GO23521@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113786>

On Thu, Mar 19, 2009 at 9:16 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
>
> Why are people reinventing the reflog, and core.logallrefupdates ?
>

Hmmm, lack of awareness of core.logallrefupdates in my case.  Thanks
for the pointer.

~ Pat
