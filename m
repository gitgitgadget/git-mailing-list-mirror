From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: remove {fetch,send}-pack from PROGRAMS as they
 are builtins
Date: Sun, 19 Apr 2009 23:27:49 -0700
Message-ID: <7vmyabltzu.fsf@gitster.siamese.dyndns.org>
References: <1240186645-4635-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 08:29:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvn0f-0000cm-UH
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 08:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489AbZDTG15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 02:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752120AbZDTG15
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 02:27:57 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42491 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224AbZDTG15 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 02:27:57 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EAF2E10D2E;
	Mon, 20 Apr 2009 02:27:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 64EAD10D2C; Mon,
 20 Apr 2009 02:27:52 -0400 (EDT)
In-Reply-To: <1240186645-4635-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Tmd1eeG7hW4gVGjDoWkJTmfhu41j?= Duy's message of "Mon, 20 Apr 2009
 10:17:25 +1000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 61E498D6-2D74-11DE-8246-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116937>

Thanks.
