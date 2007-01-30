From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Tue, 30 Jan 2007 22:31:01 +0100
Message-ID: <200701302231.02295.jnareb@gmail.com>
References: <87odognuhl.wl%cworth@cworth.org> <epobn1$jv8$1@sea.gmane.org> <20070130212511.GA5362@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 22:29:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC0Y5-0004bA-AV
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 22:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbXA3V3u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 16:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbXA3V3u
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 16:29:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:48781 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbXA3V3t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 16:29:49 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1656373uga
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 13:29:45 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kebyyFF/49n4qCiYbqPrvYctUyFV2nBMaYqqVMAlSu/z5oSaBOszGxMWKkgyF6JTa7UNCIeJc653ijz9Erc4enQJQ8852nHHv2byofsKrnpocRRDEODEmNOmrb+IrFAKGbUXm1YGzpJP+OLOT3WdJr10tvR9W3gV+v5IFJbAQeM=
Received: by 10.67.121.15 with SMTP id y15mr10709160ugm.1170192585154;
        Tue, 30 Jan 2007 13:29:45 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id o30sm11065410ugd.2007.01.30.13.29.44;
        Tue, 30 Jan 2007 13:29:44 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20070130212511.GA5362@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38206>

 Yann Dirson wrote:
> On Tue, Jan 30, 2007 at 10:02:40PM +0100, Jakub Narebski wrote:

>>> I propose this warning be removed here. Otherwise, I either add text
>>> to my instructions telling the user to ignore the warning message they
>>> get, or else I go back to "-b build" and back to all the old problems
>>> it causes.
>> 
>> I rather leave warning, but (perhaps around 1.5.1) remove the
>> instructions. RTFM (err... I'm not sure we have one about detached HEAD).
> 
> Or provide a "-q" flag to silence the warning ?

Well, it would be nice to have either when command is usually silent to
have "-q" option to it, or have "-q" option to git wrapper (especially
for gitweb).

-- 
Jakub Narebski
Poland
