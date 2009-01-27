From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] lib-rebase.sh: Document what set_fake_editor() does
Date: Tue, 27 Jan 2009 13:03:00 -0800
Message-ID: <7v3af431iz.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901271012550.14855@racer>
 <20090127085418.e113ad5a.stephen@exigencecorp.com>
 <alpine.DEB.1.00.0901271844340.3586@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0901271846340.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Haberman <stephen@exigencecorp.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 27 22:04:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRv6o-00011E-Cz
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 22:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbZA0VDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 16:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752122AbZA0VDK
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 16:03:10 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62613 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbZA0VDK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 16:03:10 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6F6BE94FD4;
	Tue, 27 Jan 2009 16:03:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E11B594FD0; Tue,
 27 Jan 2009 16:03:02 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901271846340.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Tue, 27 Jan 2009 18:46:57 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E615DEBC-ECB5-11DD-8358-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107389>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> rnyn
> Make it easy for other authors to use rebase tests' fake-editor.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Perhaps a very welcome addition, except that I did not find rnyn in my
dictionary, and the patch textually depends on /bin_sh bug ;-)
