From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-gui: commit message box doesn't respond to enter (only
 return)
Date: Fri, 26 Nov 2010 14:38:55 -0600
Message-ID: <20101126203855.GA23258@burratino>
References: <20101126170956.25856.63131.reportbug@alsuren-thinkpad.cbg.collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	David Laban <alsuren+debbugs@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 21:39:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM54b-0006PY-IB
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 21:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302Ab0KZUjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 15:39:07 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52785 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab0KZUjG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 15:39:06 -0500
Received: by gyb11 with SMTP id 11so1112355gyb.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 12:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=W2yv8YKh6gxLCMo23L6Blh/bT5Yp+guiWTHVEsZQPQc=;
        b=xEuEyLJ8WjPG3aVEMrvvRM5beHeHyv4JF2RE/LLaSDrS1CWqIXePENh4Adhzon6HJe
         zBlO6ANe9jz2pf5y/ymuMYw7PteQBaTNDiq0rjsmyQZfyyfuj4cUY1lHnw7jb8TcZRUb
         vQ/Fnzcbz6PJk3SbjIecAhwCNtQazqQHNf6+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=I8ptNyzQWWDcKB87cKx5nj3dJEGmSQvzaFAWpGgSOMQi4xsxzE/sCQ+n8m+5bDhBm/
         WW2saBJcTFQviaJvezvZ5BTviM1v98R4DUuBprYjgOPSXOcxGHqXqLs0tcxlMO7XnVO0
         j93mZUwaE7qsfs88Hmsr5Sb0pI84kF8cxfmuY=
Received: by 10.151.78.2 with SMTP id f2mr5619913ybl.417.1290803944940;
        Fri, 26 Nov 2010 12:39:04 -0800 (PST)
Received: from burratino (adsl-68-255-101-216.dsl.chcgil.ameritech.net [68.255.101.216])
        by mx.google.com with ESMTPS id q4sm2802754yba.14.2010.11.26.12.39.02
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 12:39:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101126170956.25856.63131.reportbug@alsuren-thinkpad.cbg.collabora.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162277>

Hi Pat,

David Laban wrote at http://bugs.debian.org/605041:

> Package: git-gui
> Version: 1:1.7.2.3-2
> Severity: minor
>
> If I click into the messagebox and hit enter, nothing happens.
>
> This is annoying because if I'm adding a new paragraph to my commit message, 
> I will often do <click> <enter><enter> <start typing as normal>
>
> Don't ask me why I do this. I think enter is a lighter/easier to press
> key than return, and is also on the path that my hand takes between the mouse
> and the rest of the keyboard.
>
> I have also provisionally reported the following bug in tk, but I feel like
> a bit of a n00b for doing so.
>
> http://sf.net/tracker/?func=detail&aid=3119824&group_id=12997&atid=112997

I can't reproduce this because this laptop does not have a distinct
"numpad enter" key.

Thoughts?
Jonathan
