From: Holger =?iso-8859-1?Q?Wei=DF?= <holger@zedat.fu-berlin.de>
Subject: Re: [PATCH] Documentation: Fix description of archive "--prefix"
Date: Wed, 29 Apr 2009 17:49:41 +0200
Organization: Freie =?iso-8859-1?Q?Universit=E4t?= Berlin
Message-ID: <20090429154941.GB33221014@CIS.FU-Berlin.DE>
References: <20090429134236.GU36958498@CIS.FU-Berlin.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 29 17:49:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzC2k-0006z8-KV
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 17:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757747AbZD2Ptq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 11:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758947AbZD2Ptp
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 11:49:45 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:55689 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758789AbZD2Pto (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 11:49:44 -0400
Received: from relay1.zedat.fu-berlin.de ([130.133.4.67])
          by outpost1.zedat.fu-berlin.de (Exim 4.69)
          with esmtp
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1LzC2Z-0007tq-OK>; Wed, 29 Apr 2009 17:49:43 +0200
Received: from mail.cis.fu-berlin.de ([160.45.11.138])
          by relay1.zedat.fu-berlin.de (Exim 4.69)
          with esmtp
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1LzC2Y-0001oy-0B>; Wed, 29 Apr 2009 17:49:42 +0200
Received: by Mail.CIS.FU-Berlin.DE (Exim 4.69)
          with local
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1LzC2X-02iv4g-TK>; Wed, 29 Apr 2009 17:49:41 +0200
Mail-Followup-To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20090429134236.GU36958498@CIS.FU-Berlin.DE>
X-Operating-System: IRIX64 6.5.30f
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Originating-IP: 160.45.11.138
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117901>

* Holger Wei=DF <holger@zedat.fu-berlin.de> [2009-04-29 15:42]:
> The description of the "--prefix" option suggested that a slash would
> automatically be appended to the specified <prefix>, which is not the
> case.

Nonsense, it's telling the user that appending a slash to the <prefix>
is mandatory.  Scratch my patch.

Sorry, Holger
