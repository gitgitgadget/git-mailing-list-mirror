From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] builtin-apply: fix typo leading to stack corruption
Date: Thu, 09 Oct 2008 11:07:38 -0500
Message-ID: <jYNqXNcmiUXkVpg8nytGwxXfAQx2H1W9kx59NrgLLGIbPFpol_FZVQ@cipher.nrlssc.navy.mil>
References: <48ed30f5.0707d00a.2994.6f1e@mx.google.com> <7v4p3mors6.fsf@gitster.siamese.dyndns.org> <20081009160428.GB29829@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Imre Deak <imre.deak@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 09 18:12:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kny6Y-00031f-Qg
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 18:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565AbYJIQJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 12:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752927AbYJIQJ6
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 12:09:58 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46478 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbYJIQJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 12:09:57 -0400
Received: by mail.nrlssc.navy.mil id m99G7d3b026206; Thu, 9 Oct 2008 11:07:39 -0500
In-Reply-To: <20081009160428.GB29829@spearce.org>
X-OriginalArrivalTime: 09 Oct 2008 16:07:39.0334 (UTC) FILETIME=[27038E60:01C92A29]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97866>

Shawn O. Pearce wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
>> Looks good and would look better with a sign-off.
> 
> I'm holding off on applying this change for a little, hoping Imre
> can give us a sign off, but really I don't think anyone can claim
> copyright to the < sign.  If they can, we're in big trouble.  :-)

You must have missed 48ee0b28.04eb300a.03f6.fffffe21@mx.google.com

-b
