From: <peter@vereshagin.org>
Subject: Re: 'show' pretty %B without a diff
Date: Thu, 23 Dec 2010 21:33:53 +2700
Message-ID: <6e984da6ce5898867d25012ee4250ca9@mx1.skyriver.ru>
References: <20101220073842.GC10354@external.screwed.box>
 <7vmxo0ddbm.fsf@alter.siamese.dyndns.org>
 <20101220111214.GD10354@external.screwed.box>
 <7v4oa8cobn.fsf@alter.siamese.dyndns.org>
 <20101221104641.GA8600@external.screwed.box>
 <m38vzjl1yr.fsf@localhost.localdomain> <20101221180459.GA25812@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 22 19:52:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVTn6-0005jq-9M
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 19:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842Ab0LVSvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 13:51:55 -0500
Received: from ns1.skyriver.ru ([89.108.118.221]:49798 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751489Ab0LVSvy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 13:51:54 -0500
Received: from vereshagin.org (unknown [89.108.119.221])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id E37C65A90;
	Wed, 22 Dec 2010 21:33:53 +0300 (MSK)
In-Reply-To: <20101221180459.GA25812@burratino>
X-Sender: peter@vereshagin.org
User-Agent: RoundCube Webmail/0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164095>

On Tue, 21 Dec 2010 12:04:59 -0600, Jonathan Nieder
<jrnieder@gmail.com> wrote:
> Or even "git diff-tree -s --pretty=%B <commit>" if that is the intent.

Exactly the what I asked for. Thanks!
