From: Artem Khodush <greenkaa@gmail.com>
Subject: Re: [wish] Auto-generate gitk's pretty pictures
Date: Sat, 14 Jan 2006 06:05:42 +0300
Message-ID: <40b2b7d90601131905s6bb9954fk8e359e3f066ce0c2@mail.gmail.com>
References: <46a038f90601121302x3d06898dk3f9a0ab7114ef70a@mail.gmail.com>
	 <40b2b7d90601131414o20eae573r23256ff2dfbeffa5@mail.gmail.com>
	 <46a038f90601131444m32a1a8b8w7ab16617f15ab93b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 14 04:05:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Exbjf-0007vq-KP
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 04:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945986AbWANDFo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 22:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945988AbWANDFo
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 22:05:44 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:3077 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1945986AbWANDFn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 22:05:43 -0500
Received: by uproxy.gmail.com with SMTP id m3so102826uge
        for <git@vger.kernel.org>; Fri, 13 Jan 2006 19:05:42 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W0MScH5Sq52LZm22VH0QWcbp4c2qWJpOaEDDd62H/Yisqk5tsQYmP2vQ/770POUb7i0TVIpvUdzz4iHxt7fVXh3hvZT9MWoyI+9pvoYbso48JqT2A32vfT+K+1k8G4GmWqb/1wLAjofmvA+ndrIWmQTTOgYmpvqoLJme13g4eTI=
Received: by 10.48.220.12 with SMTP id s12mr118801nfg;
        Fri, 13 Jan 2006 19:05:42 -0800 (PST)
Received: by 10.48.216.3 with HTTP; Fri, 13 Jan 2006 19:05:42 -0800 (PST)
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90601131444m32a1a8b8w7ab16617f15ab93b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14659>

On 1/14/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
>
> That looks *great* -- How hard would it be to run it alongside gitweb,
> with links back to gitweb for showing commits? And... what is it
> written in?

It's written mainly in HTML+javascript, so linking to and from it should
be simple - just add an <a> tag. But, the next feature I plan to add
is to show commits in the same window in a way like gitk does.

Artem
