From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Workflow for git dev
Date: Thu, 2 Feb 2012 16:16:39 +0100
Message-ID: <87zkd11d0o.fsf@thomas.inf.ethz.ch>
References: <CALDO3MKFdZ85w5uJEcZ6dkC7SNXxKi7BAb7r78ciFzmNdjo7eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: git <git@vger.kernel.org>
To: Tom Michaud <tom.michaud@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 16:16:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsyP1-0008TA-HE
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 16:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069Ab2BBPQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 10:16:43 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:35262 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754639Ab2BBPQm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 10:16:42 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 2 Feb
 2012 16:16:37 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 2 Feb
 2012 16:16:39 +0100
In-Reply-To: <CALDO3MKFdZ85w5uJEcZ6dkC7SNXxKi7BAb7r78ciFzmNdjo7eg@mail.gmail.com>
	(Tom Michaud's message of "Thu, 2 Feb 2012 07:59:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189652>

Tom Michaud <tom.michaud@gmail.com> writes:

> Hi all,
>
> Would someone kindly point me to a document that describes the
> workflow Junio et al use to develop git?

Documentation/howto/maintain-git.txt

The gitworkflows(7) manpage is also inspired by how development works
around here, and the pretty well-known

  http://nvie.com/posts/a-successful-git-branching-model/

has some pictures of a very similar workflow that you can look at.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
