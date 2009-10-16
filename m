From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: cgit suggestion
Date: Fri, 16 Oct 2009 02:13:27 +0200
Message-ID: <8c5c35580910151713q5dda789fn7143124149b29d26@mail.gmail.com>
References: <e95c2db40909252314t12abb6e2w9b6e9c34c7a724a5@mail.gmail.com>
	 <200909272302.30742.snakeru@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Alexey Nezhdanov <snakeru@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 02:26:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyaeE-0002YO-V5
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 02:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763349AbZJPAWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 20:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763347AbZJPAWP
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 20:22:15 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:50020 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763346AbZJPAWO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 20:22:14 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Oct 2009 20:22:14 EDT
Received: by ywh40 with SMTP id 40so216863ywh.33
        for <git@vger.kernel.org>; Thu, 15 Oct 2009 17:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=vUQ5imTkXaur0k/68RVcS8mvSdDkGwyuJjZ9GCpKDv4=;
        b=YPMPCNOvb1txo3hS6HzZSuj0tjqNrXRY7vdTNHbYYDyBGgy0DUJSslSL9ogZJ/MKsA
         TuX5dCMoNcSzfUi64D5Y/MyCHzvQs8n21pfNsduCARRIR3ByoVp+lPWSLk3skhCaO0d2
         roK4pplsOkzUT2CgH77WwI/7yljsmytTaDL88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mxbqt7c7KOCAgAawGRoGDwvJJBJpkRl8mkfoeOuwSTyHlM3uPPPtx/TnlCGcsOeC26
         BDQmpaJLjMdCNkzNPNRM4hCdmr56o0Ddd0LUUjNugqVxDmW0wH4JziaChURqYCoJ6/z5
         dgNbMAz2tjK7yl6Cw9UATm1cx3n4J9pZiOC8E=
Received: by 10.150.250.13 with SMTP id x13mr1472238ybh.230.1255652007266; 
	Thu, 15 Oct 2009 17:13:27 -0700 (PDT)
In-Reply-To: <200909272302.30742.snakeru@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130441>

[* Sorry for the late reply *]

On Sun, Sep 27, 2009 at 21:02, Alexey Nezhdanov <snakeru@gmail.com> wrote:
> Here is the diff. It adds feature of downloading 'named' tarball from the tag
> description page.

Thanks, I've applied the patch (slightly modified) to my master branch
and pushed the result to http://hjemli.net/git/cgit.

--
larsh
