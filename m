From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/6] Fix odd markup in --diff-filter documentation
Date: Fri, 8 Oct 2010 13:53:15 -0500
Message-ID: <20101008185314.GA14277@burratino>
References: <87fwwhszsf.fsf@gmail.com>
 <1286559080-27257-3-git-send-email-stepnem@gmail.com>
 <20101008173941.GA13738@burratino>
 <87bp74tvno.fsf@gmail.com>
 <20101008180327.GA13910@burratino>
 <877hhsttnj.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepan.nemec@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 20:57:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4I7m-0001Wx-Ki
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 20:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759498Ab0JHS4a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Oct 2010 14:56:30 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42921 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759493Ab0JHS43 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Oct 2010 14:56:29 -0400
Received: by ewy23 with SMTP id 23so832175ewy.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 11:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=EXG8keN79INvp1HHLO5eGYcQuty1xTHYlcOMPf1ISu4=;
        b=LwQGUDCtcLzPeOi+vKlYQaUEXjdJEsk04vdotG5ZHBVhgSrk7IXlmmzrGwCIoBE/b6
         oTC5/QG+W6wse3qT43e5aGmtdXtShWV5amjVlHTWs7WJMpauKmdS1qbkzwTsbhPF9n8e
         DN5z8uawfxucxdKHp6+UvntX86jGH9AyXkTWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=DEWSATfBGeHD+VEPQtuJ6BM2D1BxEX29Wn78D+Xm1NSlKZhAIt98Y7++ZXv7n+CD6D
         7I/cKl8UAx9nyqMw0stg1uArYoqFBopxSGQMZBJwmFF9p1riJmoAn5r5y+sExgUaRamy
         Yt86+hApNnnv6fkLl2EwYLPnaWVWUsyg9PBSk=
Received: by 10.213.19.78 with SMTP id z14mr235889eba.66.1286564187953;
        Fri, 08 Oct 2010 11:56:27 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id q54sm2049472eeh.0.2010.10.08.11.56.25
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 11:56:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <877hhsttnj.fsf@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158526>

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec wrote:

> That would mean the following instead of the original [2/6]:

Looks good, thanks.
