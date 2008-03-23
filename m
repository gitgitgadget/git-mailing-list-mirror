From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 23 Mar 2008 23:34:54 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-03-23-23-34-54+trackit+sam@rfc1149.net>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
	<7vwso85qkf.fsf@gitster.siamese.dyndns.org>
	<7vwso5r87q.fsf@gitster.siamese.dyndns.org>
	<7v8x0992hy.fsf@gitster.siamese.dyndns.org>
	<2008-03-23-13-00-28+trackit+sam@rfc1149.net>
	<7v4pax8iqc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 23:35:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdYn3-00033W-93
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 23:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910AbYCWWfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 18:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755870AbYCWWfF
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 18:35:05 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:35223 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755858AbYCWWfD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 18:35:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id DD4B1E3130;
	Sun, 23 Mar 2008 23:35:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vtLqan6CXyjE; Sun, 23 Mar 2008 23:34:56 +0100 (CET)
Received: from mail2.rfc1149.net (unknown [IPv6:2a01:5d8:5138:2f95::3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by mail.rfc1149.net (Postfix) with ESMTPS id E9123E329A;
	Sun, 23 Mar 2008 23:34:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id EF032C408D;
	Sun, 23 Mar 2008 23:34:54 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k6EWsLTpqm9v; Sun, 23 Mar 2008 23:34:54 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id C5AB5C40B8; Sun, 23 Mar 2008 23:34:54 +0100 (CET)
In-Reply-To: <7v4pax8iqc.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Sun\, 23 Mar 2008 10\:15\:23 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77971>

>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:

Junio> Do you mean 6bf4f1b (format-patch: generate MIME header as
Junio> needed even when there is format.header, 2008-03-14)?

Yup. I hadn't seen it was in master and main already :)

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
