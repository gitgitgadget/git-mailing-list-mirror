From: Sergei Organov <osv@javad.com>
Subject: Re: [RFC] git-gui USer's Survey 2007
Date: Wed, 28 Nov 2007 16:18:09 +0300
Message-ID: <87y7cimru6.fsf@osv.gnss.ru>
References: <200711252248.27904.jnareb@gmail.com> <fiet88$68n$1@ger.gmane.org>
	<e5bfff550711261125i92fb057i85d7217b18cd495d@mail.gmail.com>
	<20071127012013.GG14735@spearce.org> <fifstd$ilj$1@ger.gmane.org>
	<20071127015833.GL14735@spearce.org>
	<Pine.LNX.4.64.0711271136050.27959@racer.site>
	<fiib19$dj6$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 14:18:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxMoU-0001sC-4Z
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 14:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756430AbXK1NSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 08:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755961AbXK1NSb
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 08:18:31 -0500
Received: from javad.com ([216.122.176.236]:3485 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755955AbXK1NS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 08:18:29 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lASDIGH04209;
	Wed, 28 Nov 2007 13:18:16 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1IxMnq-0003wQ-13; Wed, 28 Nov 2007 16:18:10 +0300
In-Reply-To: <fiib19$dj6$1@ger.gmane.org> (Jakub Narebski's message of "Wed\, 28 Nov 2007 00\:59\:41 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66323>

Jakub Narebski <jnareb@gmail.com> writes:

[...]

> This is proposed set of questions for git-gui mini survey...
>
> 1. What language and what toolkit should git-gui be written in?
>    (single choice)
>
>    a. Tcl/Tk    (current implementation)
>    b. C++/Qt
>    c. C/GTK+
>    d. Python    (native)

What's this? Tkinter? If so, it's better to be spelled "Python/Tk" here,
and probably should be removed anyway as there is no apparent reason to
re-implement current Tcl/Tk in Python/Tk.

Anyway, for Python as a language, a realistic choice of GUI seems to be
between PyGtk, PyQt, and WxPython.

-- 
Sergei.
