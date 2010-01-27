From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH 0/4] Fix various integer overflows
Date: Wed, 27 Jan 2010 09:59:52 +0100
Message-ID: <20100127085952.GA21535@cuci.nl>
References: <1264530255-4682-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <7vk4v4zlhg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 10:10:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na3ut-0004VD-EA
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 10:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759Ab0A0JKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 04:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752588Ab0A0JKW
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 04:10:22 -0500
Received: from aristoteles.cuci.nl ([212.125.128.18]:36832 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab0A0JKV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 04:10:21 -0500
X-Greylist: delayed 626 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jan 2010 04:10:21 EST
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id D0CD45439; Wed, 27 Jan 2010 09:59:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vk4v4zlhg.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138120>

Junio C Hamano wrote:
>Looks trivially correct; thanks.

I'm just curious, but is this based on an actual bug which someone
experienced, or is this just based on mere theoretical code analysis?
-- 
Sincerely,
           Stephen R. van den Berg.

"Am I paying for this abuse or is it extra?"
