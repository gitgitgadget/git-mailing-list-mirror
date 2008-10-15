From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: What's in git.git (Oct 2008, #03; Tue, 14)
Date: Wed, 15 Oct 2008 10:35:30 -0500
Message-ID: <bsftmRx17krWBpVlulipoJEO1fWsD0hZfF3HOZcajX6GV66RKW8W6A@cipher.nrlssc.navy.mil>
References: <7vej2i7rt9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Arjen Laarhoven <arjen@yaph.org>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Mike Ralphson" <mike@abacus.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 17:38:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq8Ru-0004sN-4b
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 17:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbYJOPhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 11:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbYJOPg7
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 11:36:59 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:38979 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbYJOPg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 11:36:59 -0400
Received: by mail.nrlssc.navy.mil id m9FFZVl9029233; Wed, 15 Oct 2008 10:35:31 -0500
In-Reply-To: <7vej2i7rt9.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 15 Oct 2008 15:35:30.0728 (UTC) FILETIME=[A7F42280:01C92EDB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98282>


Two questions:

  1) Should a5a5a048 be in maint?
     "xdiff-interface.c: strip newline (and cr) from line before pattern matching"

  2) Do we want to stick with compat/regex on

      Darwin: Arjen
     FreeBSD: Jeff
         AIX: Mike

     now that the builtin funcname patterns have been converted to Extended
     Regular Expressions?

-brandon
