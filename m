From: Bill Lear <rael@zopyra.com>
Subject: Re: A trivial question on GIT
Date: Tue, 23 Jan 2007 13:57:31 -0600
Message-ID: <17846.26795.858074.264027@lisa.zopyra.com>
References: <a02278b00701231145l31e1be2dpff0930cbc9d6fb6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 20:57:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9RmF-0003Rq-HM
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 20:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965446AbXAWT5h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 14:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965450AbXAWT5h
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 14:57:37 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61716 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965446AbXAWT5g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 14:57:36 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0NJvY530517;
	Tue, 23 Jan 2007 13:57:34 -0600
To: "Allexio Ju" <allexio.ju@gmail.com>
In-Reply-To: <a02278b00701231145l31e1be2dpff0930cbc9d6fb6c@mail.gmail.com>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37562>

On Tuesday, January 23, 2007 at 11:45:14 (-0800) Allexio Ju writes:
>...
>After this, I would like to know how to synchronize local copy and
>keep updated  with Linus's.
>I guess cloning everyday would be bad idea as it is heavy operation.
>Can someone guide me on how to?

cd linux-2.6.git
git pull


Bill
