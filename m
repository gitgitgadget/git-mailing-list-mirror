From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: git-subtree: directory mismatch
Date: Wed, 25 Nov 2009 08:08:12 +0900
Message-ID: <20091125080812.6117@nanako3.lavabit.com>
References: <20091124195353.GA16627@lonquimay.wrk.lsn.camptocamp.com> <32541b130911241348s21e21fb8n12edf374e6a3c309@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Marc Fournier <marc.fournier@camptocamp.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 00:25:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND4l5-00069J-81
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 00:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934393AbZKXXZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 18:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934387AbZKXXZE
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 18:25:04 -0500
Received: from karen.lavabit.com ([72.249.41.33]:35558 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934382AbZKXXZD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 18:25:03 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 5FD2711B849;
	Tue, 24 Nov 2009 17:25:10 -0600 (CST)
Received: from 8128.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id YR5VAROGMEA2; Tue, 24 Nov 2009 17:25:10 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Zut8Wn9XRlrMUPDL6+XxU9nskFZ1kBemOSuVw+IkVkhAIaV4HLG9GwN6hNIQBqoU5MfmWcEd3o1gMA10BrXOUQDpjgByFSjLfMFKoPzC3bdNulumZZLEaGJHkt/QpV1QBfMBk9PN7VAit9RL26jUzDlefB5Qy/0YXYcQEzYozS8=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <32541b130911241348s21e21fb8n12edf374e6a3c309@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133598>

Quoting Avery Pennarun <apenwarr@gmail.com>

> Yup.  This is basically a bug in "git merge -s subtree": it guesses
> which subtree to merge into, rather than actually taking a prefix
> parameter.  I've been meaning to either submit a patch for this, or
> find a way to work around it.

Probably you can save time by using what was already done

http://thread.gmane.org/gmane.comp.version-control.git/76650/focus=89021



-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
