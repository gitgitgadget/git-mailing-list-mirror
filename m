From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH] t3300-*.sh: Fix a TAP parse error
Date: Sat, 28 Jul 2012 19:12:40 +0100
Message-ID: <50142B98.1030606@ramsay1.demon.co.uk>
References: <500AEB11.4050006@ramsay1.demon.co.uk> <20120721182049.GL19860@burratino> <500EEAAA.8030604@ramsay1.demon.co.uk> <7veho1exu6.fsf@alter.siamese.dyndns.org> <501043D9.70604@ramsay1.demon.co.uk> <20120725205120.GD4732@burratino> <7v1ujzbijs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 20:53:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvC9C-0004Iq-3n
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 20:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747Ab2G1Sxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 14:53:49 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:48633 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751533Ab2G1Sxs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 14:53:48 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id A90CFA0C081;
	Sat, 28 Jul 2012 19:53:47 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 1852EA0C07F;	Sat, 28 Jul 2012 19:53:47 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Sat, 28 Jul 2012 19:53:46 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7v1ujzbijs.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202450>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
>> FWIW I find Junio's test_setup name more self-explanatory.  What
>> mnemonic should I be using to remember the _fixture name?
> 
> Previous exposure to things like Rails?

I did once have a brief look at ruby, but my "new language to learn"
list was over-subscribed. (I think I went with D) So, I'm not at all
familiar with Rails.

A test-fixture may be used in various xUnit unit-test libraries.
(eg JUnit, cppUnit, etc)

ATB,
Ramsay Jones
