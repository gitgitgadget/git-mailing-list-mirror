From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Install builtins with the user and group of the
 installing personality
Date: Wed, 25 Feb 2009 01:54:02 -0800
Message-ID: <7vmyca6dvp.fsf@gitster.siamese.dyndns.org>
References: <20090223155042.14806.qmail@518da7eef5d9e4.315fe32.mid.smarden.org>
 <49A2D644.6040106@viscovery.net>
 <20090224085817.16736.qmail@86bc3118539950.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Wed Feb 25 10:55:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcGUN-0002HI-RH
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 10:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757120AbZBYJyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 04:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757176AbZBYJyM
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 04:54:12 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33526 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757022AbZBYJyL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 04:54:11 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 197FE9D6F1;
	Wed, 25 Feb 2009 04:54:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D49549D6F0; Wed,
 25 Feb 2009 04:54:03 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3E8AE132-0322-11DE-8749-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111426>

Thanks, both.
