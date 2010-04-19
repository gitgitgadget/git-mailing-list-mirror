From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [PATCH] remote add: add a --no-tags (-n) option
Date: Tue, 20 Apr 2010 01:34:38 +0200
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2010-04-20-01-34-38+trackit+sam@rfc1149.net>
References: <20100419135014.1077.28627.stgit@localhost.localdomain>
	<7vvdbnqpis.fsf@alter.siamese.dyndns.org>
	<2010-04-19-22-19-11+trackit+sam@rfc1149.net>
	<7vr5mbp0tt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 20 01:34:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O40UG-0008CN-QM
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 01:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226Ab0DSXek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 19:34:40 -0400
Received: from zoidberg.rfc1149.net ([91.121.19.179]:47955 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140Ab0DSXej (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 19:34:39 -0400
Received: from localhost (unknown [IPv6:2001:6f8:37a:2:211:2fff:fe8a:af74])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id 6766170C8;
	Tue, 20 Apr 2010 01:34:38 +0200 (CEST)
In-Reply-To: <7vr5mbp0tt.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 19 Apr 2010 14:52:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145344>

>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:

Junio> Samuel Tardieu <sam@rfc1149.net> writes:
>> I don't think we need to add "--tags" to "git remote add", do you? If
>> you do, this is not difficult to add using the "git fetch" logic you
>> describe.

Junio> I actually do suspect that would make the interface more
Junio> consistent.

Ok, sent as a v3 serie.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
