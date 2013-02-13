From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Git-aware HTTP transport docs
Date: Tue, 12 Feb 2013 17:34:16 -0800
Message-ID: <511AED98.5070809@zytor.com>
References: <20080826012643.GD26523@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 02:34:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5RFJ-0004ur-DL
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 02:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758873Ab3BMBeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 20:34:25 -0500
Received: from terminus.zytor.com ([198.137.202.10]:59844 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757683Ab3BMBeY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 20:34:24 -0500
Received: from hanvin-mobl6.amr.corp.intel.com (fmdmzpr04-ext.fm.intel.com [192.55.55.39])
	(authenticated bits=0)
	by mail.zytor.com (8.14.5/8.14.5) with ESMTP id r1D1YLHr011457
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Tue, 12 Feb 2013 17:34:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <20080826012643.GD26523@spearce.org>
X-Enigmail-Version: 1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216234>

Hi Shawn,

You wrote a really great protocol spec for the smart HTTP protocol back
in the day.  It would be really great if it could be checked into the
git repository (updated if need be).  Someone mentioned today trying to
reverse-engineer the protocol because of a lack of specs, and I was a
bit surprised to day the least.

	-hpa
