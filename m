From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack file format"
Date: Wed, 12 Jul 2006 08:27:20 -0700
Message-ID: <7vlkqyzvvr.fsf@assigned-by-dhcp.cox.net>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0607101623230.5623@g5.osdl.org>
	<20060711145527.GA32468@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0607111004360.5623@g5.osdl.org>
	<Pine.LNX.4.64.0607111010320.5623@g5.osdl.org>
	<44B4172B.3070503@stephan-feder.de>
	<Pine.LNX.4.64.0607111449190.5623@g5.osdl.org>
	<7vejwr3ftl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0607111656250.5623@g5.osdl.org>
	<slrneb96rd.dma.Peter.B.Baumann@xp.machine.xx>
	<Pine.LNX.4.64.0607120810320.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 12 17:28:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0gcb-0007kV-Ch
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 17:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWGLP10 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 11:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWGLP10
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 11:27:26 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:15603 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751411AbWGLP1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 11:27:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060712152724.SIDJ6303.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Jul 2006 11:27:24 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607120810320.5623@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 12 Jul 2006 08:13:22 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23784>

Linus Torvalds <torvalds@osdl.org> writes:

> Junio - do you want me to send an updated patch, or do you want to reverse 
> bit#7 yourself?

Pushed out in "pu" already, thanks.
