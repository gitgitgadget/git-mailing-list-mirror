From: Mike Hommey <mh@glandium.org>
Subject: Re: Should notes handle replace commits?
Date: Sat, 9 Jan 2016 10:25:42 +0900
Message-ID: <20160109012542.GA2445@glandium.org>
References: <20160108012830.GA2110@glandium.org>
 <xmqqh9in25py.fsf@gitster.mtv.corp.google.com>
 <20160108214939.GA22801@glandium.org>
 <xmqqziwfzl2s.fsf@gitster.mtv.corp.google.com>
 <20160109002510.GA30050@glandium.org>
 <xmqqmvsfzhq4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 02:25:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHiHz-0001iM-EL
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jan 2016 02:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570AbcAIBZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 20:25:51 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:40708 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbcAIBZv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 20:25:51 -0500
Received: from glandium by zenigata with local (Exim 4.86)
	(envelope-from <mh@glandium.org>)
	id 1aHiHm-0000eW-2m; Sat, 09 Jan 2016 10:25:42 +0900
Content-Disposition: inline
In-Reply-To: <xmqqmvsfzhq4.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283595>

On Fri, Jan 08, 2016 at 05:04:03PM -0800, Junio C Hamano wrote:
> It is not graft vs replace.  It is about what you replace with what
> other thing: "replace" is a content replacement mechanism, not
> identity replacement mechanism.

I guess this is where opinions diverge: in what notes are.
I'd argue notes are content just as much as the tree, except they're not
stored inside the commit.

Mike
