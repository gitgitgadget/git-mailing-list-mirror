From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: use decode_utf8 directly
Date: Sun, 03 Jun 2007 15:06:55 -0700
Message-ID: <7vmyzgn14w.fsf@assigned-by-dhcp.cox.net>
References: <200704241705.19661.ismail@pardus.org.tr>
	<200706012247.57273.ismail@pardus.org.tr>
	<7vbqfzzbq8.fsf@assigned-by-dhcp.cox.net>
	<200706012308.41335.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexandre Julliard <julliard@winehq.org>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Ismail =?utf-8?Q?D=C3=B6nmez?= <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Mon Jun 04 00:07:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuyE6-00056J-Ve
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 00:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbXFCWG7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 3 Jun 2007 18:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbXFCWG7
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 18:06:59 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:62551 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbXFCWG6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jun 2007 18:06:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070603220657.NDB7825.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 3 Jun 2007 18:06:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7A6x1X0071kojtg0000000; Sun, 03 Jun 2007 18:06:57 -0400
In-Reply-To: <200706012308.41335.ismail@pardus.org.tr> (Ismail =?utf-8?Q?D?=
 =?utf-8?Q?=C3=B6nmez's?=
	message of "Fri, 1 Jun 2007 23:08:36 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49041>

Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:

> I can try the patch if you can send me what you propose.=20

Does the recent one from Jakub work for you?
