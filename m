From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: The future of gitweb - part 2: JavaScript
Date: Sun, 17 Apr 2011 00:33:16 +0200
Message-ID: <201104170033.16346.jnareb@gmail.com>
References: <201102142039.59416.jnareb@gmail.com> <20110416215328.GA5739@external.screwed.box> <201104170019.07997.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Vereshagin <peter@vereshagin.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 00:33:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBE3b-0007Bk-Jl
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 00:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759199Ab1DPWdU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Apr 2011 18:33:20 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53527 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755918Ab1DPWdS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 18:33:18 -0400
Received: by bwz15 with SMTP id 15so2981429bwz.19
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 15:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=9fJvLCsxPpcHucW7xGPSNv1bhXPIs7gwLEmOEkASB8g=;
        b=DWVDgj/6iVmGUQo3Dh/9/TKik1r+eZZk3T1epgzpIU/uUW9kCs5OqA1/dcYhuDYaGB
         9OJv0XWiXURSlCSfXoBtnq0TZXH3V9cBGxPv4EfQXyHheZdk4MEGafFEwz2kkC+uRbE0
         w2TFvdQY7Y6bOCNLlr+KYjG+xTqbDzJcdmQpg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jghZ8QhxEkdo/9g2mAtigiuWck3P+H868xF4D8+hFXS5S4dc/zOyBg9GkeI2BQWM79
         s2qX1gRkiO5hp+Ae9/RgThAa+Qvp8njgJV8vW7NZ0rIrrVOGAA45PtAOEKoIExM0wQ7l
         6GAstDDQLLtpYTwE02sb5QTeGn1lL9f720rUk=
Received: by 10.204.126.144 with SMTP id c16mr2802824bks.6.1302993196776;
        Sat, 16 Apr 2011 15:33:16 -0700 (PDT)
Received: from [192.168.1.13] (abvu151.neoplus.adsl.tpnet.pl [83.8.218.151])
        by mx.google.com with ESMTPS id t1sm2319223bkx.7.2011.04.16.15.33.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Apr 2011 15:33:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201104170019.07997.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171699>

Jakub Narebski wrote:

> Gitweb is written in Perl. =9AThis language is good for prototyping, =
for
> fast development, and for easy writing of a web app. =9AGitweb works =
on
> porcelain level - it is an user interface (a web one).
>=20
> C is good for performance. =9Agit-http-backend is only an example
> implementation. =9AThe "smart" HTTP protocol works on porcelain level=
=2E
                                                      ^^^^^^^^^

I meant plumbing here.
--=20
Jakub Narebski
Poland
