From: Junio C Hamano <gitster@pobox.com>
Subject: Planning to pass the baton to an interim maintainer
Date: Sun, 14 Oct 2012 11:23:07 -0700
Message-ID: <7vsj9gyktw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 14 20:23:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNSqP-0002gU-Jw
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 20:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696Ab2JNSXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 14:23:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38325 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752659Ab2JNSXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 14:23:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73D4898B6;
	Sun, 14 Oct 2012 14:23:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=L
	J7RmQJyvD7KSoVDa1AWoepIsA8=; b=lGPzS8bJMiCFrdE5hjeEeYHZDf4zfhuO+
	ghT5WQ9T6NtDvMPDRK38OId7+1iDkwl5o1spdrrTq3x6oQ98M4FDFyT2ibG2lNHO
	5jDZ4XJnnaO0vifZDiYNWb9rZCEpx8O4eRIhqxCGO8YrJGjTRGdZ5yrcOh5uo3Ta
	nq1NQ4d9K4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=NO/M2Qme2vdc87P5ea03DOedhdS2Z7RcSJlo2fz9Il+pwduIFaSUOZ8z
	KDqyocq+FeU9wVi3/e/1t82uVFxnvJMgXD6kEd0IwaINau0yUxHSaaXvHYbKyv78
	3Eym25KVRAIA8/qS+wDXxDreiHYLiQvgYllkdfdXQQJPTKdsbvI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61A5198B5;
	Sun, 14 Oct 2012 14:23:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF87598B3; Sun, 14 Oct 2012
 14:23:08 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 346EA366-162C-11E2-AAB9-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207681>

I am planning to

 * tag 1.8.0 final on Oct 21st (Sun);
 * go offline on Oct 22nd (Mon); and
 * come back online on Nov 12th (Mon).

Peff, could you be the interim maintainer as you've done in earlier
years while I was away?

Thanks.
