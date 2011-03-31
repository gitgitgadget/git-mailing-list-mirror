From: "Matt Seitz (matseitz)" <matseitz@cisco.com>
Subject: RE: git gui equivalent to git checkout -b
Date: Thu, 31 Mar 2011 10:52:02 -0700
Message-ID: <70952A932255A2489522275A628B97C30FE5BB2C@xmb-sjc-233.amer.cisco.com>
References: <imrapc$f7u$1@dough.gmane.org> <87y63wpy0o.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: "Pat Thoyts" <patthoyts@users.sourceforge.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 31 19:52:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5M2Z-0006yl-49
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 19:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758771Ab1CaRwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 13:52:09 -0400
Received: from sj-iport-2.cisco.com ([171.71.176.71]:35108 "EHLO
	sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758757Ab1CaRwH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 13:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=matseitz@cisco.com; l=354; q=dns/txt;
  s=iport; t=1301593927; x=1302803527;
  h=mime-version:content-transfer-encoding:subject:date:
   message-id:in-reply-to:references:from:to:cc;
  bh=h7vf0CzjulNGHt9v7rtR0tPRZ+LkZwwtNVzjuV/NShs=;
  b=PGlx1H7jXHMJ4p4a8EKdYk2H/dpShOhrsJyefPv+8t2bthaCcA9geiNL
   W9sZjWwyrlkHZoxaw27SPQUPumjE1nIbOiKn7CKPtqaomayNAneML3Mf1
   EvYswrSchYbXEW6pfCSUx8lKrIQL6jrc8+K8/40G6ZdF3nvibIu58ef7u
   M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuQHAOm+lE2rRDoJ/2dsb2JhbACYUY0Bd4h5mi6cNoVrBIVBiys
X-IronPort-AV: E=Sophos;i="4.63,276,1299456000"; 
   d="scan'208";a="328364389"
Received: from mtv-core-4.cisco.com ([171.68.58.9])
  by sj-iport-2.cisco.com with ESMTP; 31 Mar 2011 17:52:04 +0000
Received: from xbh-sjc-221.amer.cisco.com (xbh-sjc-221.cisco.com [128.107.191.63])
	by mtv-core-4.cisco.com (8.14.3/8.14.3) with ESMTP id p2VHq4Wl010894;
	Thu, 31 Mar 2011 17:52:04 GMT
Received: from xmb-sjc-233.amer.cisco.com ([128.107.191.88]) by xbh-sjc-221.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 31 Mar 2011 10:52:03 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <87y63wpy0o.fsf@fox.patthoyts.tk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git gui equivalent to git checkout -b
Thread-Index: Acvu2fJawrQPFwLKSoKXd1BWC78GiwA8hsFg
X-OriginalArrivalTime: 31 Mar 2011 17:52:04.0019 (UTC) FILETIME=[5812E030:01CBEFCC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170506>

> From: Pat Thoyts [mailto:patthoyts@users.sourceforge.net]
> 
> "Matt Seitz" <matseitz@cisco.com> writes:
> 
> >What is the git gui equivalent to "git checkout -b"?
> >
> >If I go to "Branch->Create", I see an option to "Checkout After
Creation",
> >but I want to be sure that is the right choice.
> 
> Create.

Thanks for your help!
