From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: v1.5.4 plans
Date: Tue, 11 Dec 2007 10:24:35 -0500
Message-ID: <1197386675.5001.4.camel@hinata.boston.redhat.com>
References: <20071022061115.GR14735@spearce.org>
	 <7vodeecyni.fsf@gitster.siamese.dyndns.org>
	 <7vpryqwtt7.fsf@gitster.siamese.dyndns.org>
	 <7vk5ot40w9.fsf@gitster.siamese.dyndns.org>
	 <7vy7d43ptc.fsf@gitster.siamese.dyndns.org>
	 <7vabpg9x5k.fsf@gitster.siamese.dyndns.org>
	 <7vy7cwsi3p.fsf@gitster.siamese.dyndns.org>
	 <7vk5o6jbq9.fsf@gitster.siamese.dyndns.org>
	 <7v63zjgoel.fsf@gitster.siamese.dyndns.org>
	 <7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
	 <7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
	 <7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
	 <7vve78qhtf.fsf@gitster.siamese.dyndns.org>
	 <7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 16:25:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J26z3-0000Zd-Vh
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 16:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbXLKPY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 10:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbXLKPY7
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 10:24:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41072 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511AbXLKPY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 10:24:58 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lBBFOg0l029086;
	Tue, 11 Dec 2007 10:24:42 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBBFOfON008079;
	Tue, 11 Dec 2007 10:24:41 -0500
Received: from [192.168.1.100] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBBFOeH8003631;
	Tue, 11 Dec 2007 10:24:41 -0500
In-Reply-To: <7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67872>

On Mon, 2007-12-10 at 14:37 -0800, Junio C Hamano wrote:
>  * We have a handful deprecation notices in the draft release notes, but
>    if I recall correctly, Nico wanted to add a few more.  We need to
>    come up with a wording that is easy to understand for the end users
>    to decide which ancient versions will be affected.

Can we deprecate .git/branches?

Kristian
