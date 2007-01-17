From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] git-reset: make the output as the fetch output
Date: Wed, 17 Jan 2007 14:27:15 +0100
Message-ID: <8aa486160701170527p69c59510i2daf99e7e805ec5a@mail.gmail.com>
References: <87odox23u9.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jan 17 14:27:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Aox-0008S7-De
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 14:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbXAQN1R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 08:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbXAQN1R
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 08:27:17 -0500
Received: from nz-out-0506.google.com ([64.233.162.228]:11553 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbXAQN1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 08:27:16 -0500
Received: by nz-out-0506.google.com with SMTP id s1so430856nze
        for <git@vger.kernel.org>; Wed, 17 Jan 2007 05:27:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rxlCN90PqwwAnD20Fq5wt4Y6RTR7PikvfXba+tZ/s3d0TyK2RtrZlMMmW9eNsoVPgAxeRrpiOYSQgNHTvw8BZNDI9qrbMWFMKmfOxmRuqFOxUGLln/1ClYZlq5/cCoJf67a8qsRApkCJXTkzwSglR+DQMT7Sf+GSxETtksovyJg=
Received: by 10.35.91.10 with SMTP id t10mr12153154pyl.1169040435584;
        Wed, 17 Jan 2007 05:27:15 -0800 (PST)
Received: by 10.35.78.7 with HTTP; Wed, 17 Jan 2007 05:27:15 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
In-Reply-To: <87odox23u9.fsf@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36999>

Hi *,

> @@ -84,14 +85,20 @@ fi
[...]
> +    echo "* HEAD: reset to $commit"
[...]

perhaps?
echo "* HEAD: resetted to $commit"

Santi
