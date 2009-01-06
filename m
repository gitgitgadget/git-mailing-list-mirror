From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 tested-v2] git-sh-setup: Fix scripts whose PWD is a
 symlink to a work-dir on OS X
Date: Tue, 06 Jan 2009 00:18:29 -0800
Message-ID: <7v63ksluei.fsf@gitster.siamese.dyndns.org>
References: <8C7E36D0-C037-427D-B6E2-4050CC767CD0@marzelpan.de>
 <1231105649-12998-1-git-send-email-marcel@oak.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com, ae@op5.se,
	j.sixt@viscovery.net, git-dev@marzelpan.de
To: "Marcel M. Cary" <marcel@oak.homeunix.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 09:20:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK7AS-0007ga-QZ
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 09:20:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbZAFISj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 03:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbZAFISj
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 03:18:39 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40335 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbZAFISi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 03:18:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4413E8DE2F;
	Tue,  6 Jan 2009 03:18:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0B8048DE2C; Tue,
  6 Jan 2009 03:18:30 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9EA7FBA6-DBCA-11DD-A254-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104653>

Thanks; queued.
