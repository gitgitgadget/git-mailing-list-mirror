From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: GSoC - Designing a faster index format
Date: Wed, 21 Mar 2012 12:25:47 +0100
Message-ID: <87aa3aw5z8.fsf@thomas.inf.ethz.ch>
References: <CAKTdtZm3qfG1rcoashDoMoqtD34JJDUDtDruGqGn9bSMzQTcFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Git Mailing List <git@vger.kernel.org>
To: elton sky <eltonsky9404@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 12:25:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAJfw-0002kX-Ug
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 12:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046Ab2CULZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 07:25:51 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:5853 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708Ab2CULZu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 07:25:50 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 21 Mar
 2012 12:25:47 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 21 Mar
 2012 12:25:47 +0100
In-Reply-To: <CAKTdtZm3qfG1rcoashDoMoqtD34JJDUDtDruGqGn9bSMzQTcFA@mail.gmail.com>
	(elton sky's message of "Wed, 21 Mar 2012 10:10:04 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193571>

elton sky <eltonsky9404@gmail.com> writes:

> I got questions like: how each operations affect index? how cache tree
> data and index is stored?
> Maybe you can point me how I should catch up quickly. I went through
> the article "git-for-computer-scientists", that quite makes sense.

In addition to what Nguyen Thai Ngoc Duy said, check out the
(sub)threads

  http://thread.gmane.org/gmane.comp.version-control.git/190016/focus=190132
  [origins of the GSoC project idea]

  http://thread.gmane.org/gmane.comp.version-control.git/192014/focus=192025
  [perspectives of core developers in reply to the idea]

  http://thread.gmane.org/gmane.comp.version-control.git/186244/focus=186282
  http://thread.gmane.org/gmane.comp.version-control.git/186357
  [the last few discussions about cache-tree]

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
