From: Stefan Tatschner <rumpelsepp@sevenbyte.org>
Subject: Re: [PATCH] SubmittingPatches : WIP tag in patches
Date: Fri, 26 Feb 2016 09:19:50 +0100
Message-ID: <56D00AA6.4060302@sevenbyte.org>
References: <56D05BA2.1090502@zoho.com>
 <CAPig+cT9Aqm0+AEGz0F-CTihMJtMw45fq4h6zxKs_7uxHak0bg@mail.gmail.com>
 <56D05EE9.8020400@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@zoho.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 09:38:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZDvL-00088B-6m
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 09:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578AbcBZIiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 03:38:52 -0500
Received: from mail.sevenbyte.org ([5.9.90.188]:46101 "EHLO mail.sevenbyte.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750935AbcBZIiv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 03:38:51 -0500
X-Greylist: delayed 1138 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Feb 2016 03:38:51 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.sevenbyte.org (Postfix) with ESMTP id 1F5641260713;
	Fri, 26 Feb 2016 09:19:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at sevenbyte.org
Received: from mail.sevenbyte.org ([127.0.0.1])
	by localhost (mail.sevenbyte.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HiO965isxTmf; Fri, 26 Feb 2016 09:19:51 +0100 (CET)
In-Reply-To: <56D05EE9.8020400@zoho.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287554>

On 26.02.2016 15:19, Pranit Bauva wrote:
> I have to inoculate the habit of signing off every time.

There is this in git-config(1); hope that helps.

format.signOff
    A boolean value which lets you enable the -s/--signoff option of
    format-patch by default.  Note: Adding the Signed-off-by: line to a
    patch should be a conscious act and means that you certify you have
    the rights to submit this work under the same open source license.
    Please see the SubmittingPatches document for further discussion.

Stefan
