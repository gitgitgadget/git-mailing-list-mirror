From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/fast-export: Document --import-marks and
 --export-marks options
Date: Mon, 09 Jun 2008 23:47:48 -0700
Message-ID: <7vve0hdbvv.fsf@gitster.siamese.dyndns.org>
References: <1212663163-43064-1-git-send-email-pdebie@ai.rug.nl>
 <1212845104-79789-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Tue Jun 10 08:49:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5xf9-0006Yy-6D
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 08:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbYFJGsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 02:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbYFJGsE
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 02:48:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56754 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbYFJGsB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 02:48:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E653C150A;
	Tue, 10 Jun 2008 02:47:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 563AE1509; Tue, 10 Jun 2008 02:47:56 -0400 (EDT)
In-Reply-To: <1212845104-79789-1-git-send-email-pdebie@ai.rug.nl> (Pieter de
 Bie's message of "Sat, 7 Jun 2008 15:25:04 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2A685062-36B9-11DD-8369-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84478>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> This adds a description for git-fast-export's --import-marks and
> --export-marks options to its man page.
> ---
>
> I forgot to add the options to the man page. Perhaps this should be squashed
> on top of the other patch?

Sign-off and tests are missing.
