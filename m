From: linux@horizon.com
Subject: Does anyone have any benchmarks against CVS?
Date: 11 Jun 2007 05:04:51 -0400
Message-ID: <20070611090451.26209.qmail@science.horizon.com>
Cc: linux@horizon.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 11:05:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxfpe-0002TP-RW
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 11:05:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125AbXFKJEx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 05:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753457AbXFKJEx
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 05:04:53 -0400
Received: from science.horizon.com ([192.35.100.1]:16335 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755267AbXFKJEw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 05:04:52 -0400
Received: (qmail 26210 invoked by uid 1000); 11 Jun 2007 05:04:51 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49836>

It seems to be common knowledge that git is a heck of a lot faster than
CVS at most operations, but I'd like to do a little evangelizing and
I can't seem to find a benchmark to support that claim.

Am I just blind?

I could find a code base and measure myself, but perhaps someone who's
been hacking on CVS converters already has a reasonable code base
in both forms that could be used for testing?
