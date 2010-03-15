From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: FEATURE REQUEST: Comment assignment on branches
Date: Mon, 15 Mar 2010 22:32:21 +0100
Message-ID: <20100315213221.GA12941@vidovic>
References: <be8f531d1003150133n3ea64109u7d573dbd533ffa48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Maxim Treskin <zerthurd@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 22:32:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrHu5-0004BP-C2
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 22:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757194Ab0COVcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 17:32:31 -0400
Received: from mail-pz0-f200.google.com ([209.85.222.200]:37177 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756988Ab0COVca (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 17:32:30 -0400
Received: by pzk38 with SMTP id 38so2538944pzk.33
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 14:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=/zHQ+6tfwlNiDCy08OTH0hYkpkazPkuEY8Tc8qMB36A=;
        b=ItxBYYD+kdtb5zG0gnyb3/M5WWO8tY8kljr812gYd5ic/YEZn24jj/CdZqovVTalyH
         uzTdEiaQzBAHFb/sfUUkfs/D1YQcsQEXqzeOBK7yvi5A/jIa7eEbBxyIPgxrCprfzZfE
         v+dTH0xcScf16zxhYHyH6CdSXlmtsfGTuievo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hQ78vYIQ5XIpPsjyx2dkleCPqNEDbLySQgMSpf3Ze0BUYsPf4AqZj5cfsKQj1lKl2l
         g0bEpIDagqIfRwJ5CMf2z56xiXMnSKoI6RRV9lhHft4zJeG6SB6gkKZCX8+Hv2YLiOIZ
         3H7f/I73P29164NE6gbY4+ybABtWQBecoqe9o=
Received: by 10.114.249.29 with SMTP id w29mr3324809wah.223.1268688748355;
        Mon, 15 Mar 2010 14:32:28 -0700 (PDT)
Received: from @ (88-121-113-67.rev.libertysurf.net [88.121.113.67])
        by mx.google.com with ESMTPS id 12sm401781pwj.5.2010.03.15.14.32.24
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Mar 2010 14:32:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <be8f531d1003150133n3ea64109u7d573dbd533ffa48@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142256>

The 15/03/10, Maxim Treskin wrote:

> Is it possible to add comments assignment to branches?
> Something like:

Aren't you looking for 'git notes'?

-- 
Nicolas Sebrecht
