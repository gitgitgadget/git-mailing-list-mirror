From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: fix options '-o' and '--origin' to be recognised again
Date: Wed, 19 Dec 2007 01:45:39 -0800
Message-ID: <7vbq8nvwzg.fsf@gitster.siamese.dyndns.org>
References: <20071219091515.GA20707@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
To: Marco Roeland <marco.roeland@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Dec 19 10:46:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4vVV-0007Qt-Fp
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 10:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbXLSJqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 04:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbXLSJqC
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 04:46:02 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65488 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbXLSJqB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 04:46:01 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AB7F16BB0;
	Wed, 19 Dec 2007 04:45:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 30A166BAF;
	Wed, 19 Dec 2007 04:45:47 -0500 (EST)
In-Reply-To: <20071219091515.GA20707@fiberbit.xs4all.nl> (Marco Roeland's
	message of "Wed, 19 Dec 2007 10:15:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68877>

Thanks.  That indeed was embarrassing.
