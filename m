From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: white spaces in a patch
Date: Wed, 17 Dec 2008 13:16:43 +0100
Message-ID: <bd6139dc0812170416w5e2cc537v6143b6071f9b8225@mail.gmail.com>
References: <dac45060812162331k19272488r4e95e0555e7a6db9@mail.gmail.com>
	 <7vej07p84i.fsf@gitster.siamese.dyndns.org>
	 <dac45060812170344u368ffd7fx4e86253b4a13ffc7@mail.gmail.com>
	 <bd6139dc0812170413j5ed2d9eak89df8517bc91c5fd@mail.gmail.com>
	 <dac45060812170413w7c8cffaifa1a0f3b649474e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Mark Ryden" <markryde@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 13:18:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCvLn-0006oN-1u
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 13:18:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbYLQMQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 07:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbYLQMQp
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 07:16:45 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:33338 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbYLQMQo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 07:16:44 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1533032yxm.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 04:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=6PMU0SWcXaY83pAwHdPNFJzwA5RBJndzodGegQjHtso=;
        b=I/ORpSulaf9pKcbieKM6xUrFPNK2Cfnb4TgGCf76Po1J2nBSrktYh2Dtjr8hEARfP8
         S0cjUrlBNcGJBsymi/0dDtCvEmbO+VDNne93rBGekz2Wby/fgf34nMccZbuK7i+1Wn5F
         z54ZgRhiX/S8LgchWOGs1MUZfhlLDId3aQHlM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=WE9sQsDC6Man05LsFOdkovzQlB9kVidM02kA+QimpB16q0EifjaTno62J+UsgxR5rm
         Bbe2pIr6GGYoLY/JKlFD911luBodOv6tgNQVTBNCJcF6PGxSyukki3lGpQrVUrBcttMS
         HlUF+aS4GAOxXJJ3PAwbYRGu04+dSSEShcaf0=
Received: by 10.150.216.3 with SMTP id o3mr1283185ybg.96.1229516203319;
        Wed, 17 Dec 2008 04:16:43 -0800 (PST)
Received: by 10.151.13.13 with HTTP; Wed, 17 Dec 2008 04:16:43 -0800 (PST)
In-Reply-To: <dac45060812170413w7c8cffaifa1a0f3b649474e4@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 90a6b775aa0e2f5b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103341>

On Wed, Dec 17, 2008 at 13:13, Mark Ryden <markryde@gmail.com> wrote:
> On Wed, Dec 17, 2008 at 2:13 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> Do you have color on?

$ git config color.diff true


-- 
Cheers,

Sverre Rabbelier
