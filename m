From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fatal: git grep: cannot generate relative filenames containing
 '..'
Date: Thu, 15 Jan 2009 18:12:27 -0800
Message-ID: <7vhc40ov78.fsf@gitster.siamese.dyndns.org>
References: <20090115222905.8157.qmail@science.horizon.com>
 <alpine.DEB.1.00.0901160307290.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: George Spelvin <linux@horizon.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 16 03:14:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNeDh-0000IL-80
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 03:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760322AbZAPCMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 21:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755268AbZAPCMh
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 21:12:37 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34898 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754028AbZAPCMg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 21:12:36 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1FBB01C723;
	Thu, 15 Jan 2009 21:12:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8175D1B7D5; Thu,
 15 Jan 2009 21:12:28 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901160307290.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Fri, 16 Jan 2009 03:07:59 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 23BAD890-E373-11DD-B786-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105908>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 15 Jan 2009, George Spelvin wrote:
>
>> Could someone fix this some day?
>
> Yes, someone could.

Or perhaps someone did more than two years ago with --full-name?
