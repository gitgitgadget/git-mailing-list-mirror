From: Geoffrey Lee <geoffreyj.lee@gmail.com>
Subject: Re: Windows release
Date: Tue, 3 Feb 2009 08:51:04 -0800
Message-ID: <83d7aaa40902030851l1ddec73fv4f054ef939a8936@mail.gmail.com>
References: <450196A1AAAE4B42A00A8B27A59278E70977F81A@EXCHANGE.trad.tradestation.com>
	 <f488382f0902030842x6e7466ffm4668abde23e67bea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 17:52:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUOVk-0006IF-QO
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 17:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbZBCQvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 11:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752485AbZBCQvH
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 11:51:07 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:47811 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbZBCQvG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 11:51:06 -0500
Received: by qyk4 with SMTP id 4so2717146qyk.13
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 08:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=QXYf8Mh5LXlaVfPcxrimncuvF0Nro2pL0nIXMygnVak=;
        b=FwRgRRDURULxG7CzlI4xcUm4e0bUWCEKQP5vw9EnoH63KxROkZeha9okpqY59n3++y
         LAaGIxTsQf/JC0+00lD/mTvS6BakXvJfTsmuyEB9eJYlE99Ving/DoldQrhTsiCZC3Dt
         ojlwcdJcCxVteWveBXsghiMucjFKtGDyzAios=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=Wz2Zn4rBJ8P98GIZY+l7eQkQOkxEamTUYSa0L1mNFG6HJiYwfhtLwFYGfE/BZyPLiV
         PyAwp3obYeFZ5mOSvRiC2ijqkpmsamc9YEz+yEXvXslufx5Sseko7DQs64XvNn9u5HyQ
         K7BGfGe4c2Ecj8a2oslaREOLM56WXwsKv3znM=
Received: by 10.214.217.5 with SMTP id p5mr8619640qag.342.1233679864844; Tue, 
	03 Feb 2009 08:51:04 -0800 (PST)
In-Reply-To: <f488382f0902030842x6e7466ffm4668abde23e67bea@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108211>

On Tue, Feb 3, 2009 at 8:42 AM, Steven Noonan <steven@uplinklabs.net> wrote:
>> I want to update my git installation to the latest stable version, and
>> I'm running Windows.  In your download page
>> <http://git-scm.com/download> the link next to Cygwin is
>> <http://www.cygwin.com/setup.exe> which would seem to be the installer
>> for Cygwin itself, not for the Cygwin version of the git executables.
>>
>> Am I missing something here?
>>
>> --John
>
> Cygwin doesn't have a binary package system (i.e. rpm, deb, etc), so
> you either have to run the Cygwin installer to get the latest one they
> support or compile it yourself via Cygwin.
>
> - Steven

There is also msysGit if you don't want to deal with Cygwin.
http://code.google.com/p/msysgit/

-Geoffrey Lee
