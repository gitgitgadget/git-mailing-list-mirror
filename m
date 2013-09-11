From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 00/21] np/pack-v4 updates
Date: Wed, 11 Sep 2013 12:24:14 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309111220130.20709@syhkavp.arg>
References: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
 <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_YS94jokWDdqByUKszhJLgw)"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 18:24:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJnDI-00071x-Nw
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 18:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754971Ab3IKQYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 12:24:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57833 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959Ab3IKQYP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 12:24:15 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSY004P2YWFTKI0@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 11 Sep 2013 12:24:15 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 7FC4D2DA0625; Wed, 11 Sep 2013 12:24:14 -0400 (EDT)
In-reply-to: <1378879582-15372-1-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234578>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_YS94jokWDdqByUKszhJLgw)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Wed, 11 Sep 2013, Nguyễn Thái Ngọc Duy wrote:

> This contains fixups for some of my patches, some of Nico's, adds v4
> support to unpack-objects because the test suite needs it. With these,
> when force generating pack v4 unconditionally, the remaining failed
> tests are:
[...]

@junio: I've folded those patches into my branch, along with the better 
fix for the compilation issue you found.  So you may simply replace the 
branch you have in  pu with mine directly if you wish.

git://git.linaro.org/people/nico/git


Nicolas

--Boundary_(ID_YS94jokWDdqByUKszhJLgw)--
