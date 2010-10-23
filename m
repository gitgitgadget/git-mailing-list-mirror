From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 00/11] More consistant terminology ("remote-tracking
 branch", "not updated")
Date: Sat, 23 Oct 2010 14:11:04 -0500
Message-ID: <20101023191104.GM21040@burratino>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <m3fwvwkadi.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 23 21:15:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9jYU-0001qF-Mo
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 21:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932949Ab0JWTO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 15:14:59 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40479 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759122Ab0JWTOz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 15:14:55 -0400
Received: by gyg4 with SMTP id 4so1350960gyg.19
        for <git@vger.kernel.org>; Sat, 23 Oct 2010 12:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PWBsEOH06c8upuznq/zcjR822pX/sg2fc0E6LBpAhMM=;
        b=or9jJrEKFpC4iDKtwl/T5mll1Arc8VJ4tYMUj4NQD10l2XIB8r0NzYI3vNjkMN09Y8
         jqCAiBM+b7q4Bi6WNBKv6p6PdgUZjChTttgxZYsjnh+Hqrs0Mn0KEru6HEYzV3npF6uH
         m8g3SMZ0orqpPXntBJpz6wXQ57YsYvyD8mK0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=U3ht7OUYIhxb/Gmz2lmEgsWghs9dyb+edakl/ic9m980EJubrTyuhkMN1YNOhZAl6+
         B8qqt6VuKiWMcz6+2UyuizKMbsSMkjoBGYzBoq9aUYZJtgCI7T70VLiM0RdWJJOn5LZX
         mc3zOIgcca/vjJJbK3FT5PdUv59duXk75cKFY=
Received: by 10.151.109.3 with SMTP id l3mr9315737ybm.56.1287861294688;
        Sat, 23 Oct 2010 12:14:54 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id z33sm3703070yhc.33.2010.10.23.12.14.52
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Oct 2010 12:14:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m3fwvwkadi.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159821>

Jakub Narebski wrote:
> Matthieu Moy <Matthieu.Moy@imag.fr> writes:

>> this is an attempt to be more consistant in the terminology used in Git.
>
> Thank you very much for your work!

Yes, seconded!  

I've sent comments as replies to patches 1, 2, 3, 4, 5, 7, 8, and 9.
Except as noted,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

These changes are not a moment too soon.
