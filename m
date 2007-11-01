From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: Update Japanese strings
Date: Wed, 31 Oct 2007 21:14:01 -0700
Message-ID: <7v640mfvqu.fsf@gitster.siamese.dyndns.org>
References: <200710311412.l9VECpnI002616@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spearce@spearce.org, git@vger.kernel.org
To: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 05:14:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InRRn-0007bv-Fo
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 05:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbXKAEOK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Nov 2007 00:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbXKAEOJ
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 00:14:09 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:43393 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbXKAEOI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Nov 2007 00:14:08 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 7048C2F2;
	Thu,  1 Nov 2007 00:14:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E81758DD4A;
	Thu,  1 Nov 2007 00:14:25 -0400 (EDT)
In-Reply-To: <200710311412.l9VECpnI002616@mi0.bluebottle.com>
	(nanako3@bluebottle.com's message of "Wed, 31 Oct 2007 23:12:12
	+0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62912>

=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93  <nanak=
o3@bluebottle.com> writes:

> This updates the Japanese translation file.

This seems to be missing an earlier suggestion from Christian.

diff --git a/po/ja.po b/po/ja.po
index e4491f7..f3a547b 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -1776,7 +1776,7 @@
 #: lib/status_bar.tcl:83
 #, tcl-format
 msgid "%s ... %*i of %*i %s (%3i%%)"
-msgstr "%1$s ... %3$*i %4$s =E4=B8=AD=E3=81=AE %$2*i (%5$3i%%)"
+msgstr "%1$s ... %4$*i %6$s =E4=B8=AD=E3=81=AE %2$*i (%7$3i%%)"
=20
 #: lib/transport.tcl:6
 #, tcl-format
