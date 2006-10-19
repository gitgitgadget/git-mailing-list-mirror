From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Add revspec documentation for ':path', ':[0-3]:path' and git-describe
Date: Thu, 19 Oct 2006 11:57:02 +0700
Message-ID: <fcaeb9bf0610182157i7cce5007r9552b2bf06988326@mail.gmail.com>
References: <20061019030455.GA10554@localhost>
	 <7vlkncx6d2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 06:57:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaPxs-00022v-EL
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 06:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422938AbWJSE5F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 00:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423092AbWJSE5F
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 00:57:05 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:48341 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1422938AbWJSE5C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 00:57:02 -0400
Received: by wx-out-0506.google.com with SMTP id h29so548643wxd
        for <git@vger.kernel.org>; Wed, 18 Oct 2006 21:57:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ibsejQ6UqDVxh6JUKAs32hB21nDsF+C7WvILFL4e/PIPtHVTijj1WokuT3DF++xjcNEl4+DJgRF6EJ/xl+BCb+cVMRoYJuxnsJeRqg6zWsd7D57Rwyj4+D8oUZ3nL7pTX92fbGBmoZICltlAH9WBQiBLAMppfHpMj8ebOuf5r98=
Received: by 10.70.130.19 with SMTP id c19mr17576178wxd;
        Wed, 18 Oct 2006 21:57:02 -0700 (PDT)
Received: by 10.70.46.13 with HTTP; Wed, 18 Oct 2006 21:57:02 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vlkncx6d2.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29321>

On 10/19/06, Junio C Hamano <junkio@cox.net> wrote:
> > As I'm not very good at English, please correct any mistake I made
>
> Thanks.  I do not know about English, but I'd move things around
> to group them better.  Most talk about committish but the
> colon-path are about trees and blobs.

It's ok to me.
-- 
Duy
