From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] gitweb: linkify author/committer names with search
Date: Wed, 14 Oct 2009 18:55:43 +0200
Message-ID: <BB11D6A2-212D-4FDB-AFCC-B8BDC7ADB208@wincent.com>
References: <1255486344-11891-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 19:00:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My7Cf-0000Tk-02
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 18:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934985AbZJNQ4b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Oct 2009 12:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934983AbZJNQ4b
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 12:56:31 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:36472 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934942AbZJNQ4a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Oct 2009 12:56:30 -0400
Received: from [192.168.1.2] ([80.30.13.217])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n9EGth6u018930
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 14 Oct 2009 12:55:47 -0400
In-Reply-To: <1255486344-11891-1-git-send-email-bebarino@gmail.com>
X-Mailer: Apple Mail (2.1076)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130307>

El 14/10/2009, a las 04:12, Stephen Boyd escribi=F3:

> It's nice to search for an author by merely clicking on their name in
> gitweb. This is usually faster than selecting the name, copying the
> selection, pasting it into the search box, selecting between
> author/committer and then hitting enter.

What about installs where search is turned off? (ie. with "$feature=20
{'search'}{'default'} =3D [undef];" in gitweb.conf)

Cheers,
Wincent
