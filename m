From: Karl Wiberg <kha@treskal.com>
Subject: Re: [StGit PATCH v2 0/6] add support for git send-email
Date: Wed, 2 Dec 2009 08:08:55 +0100
Message-ID: <b8197bcb0912012308n249f70e4j54e76d70f9601279@mail.gmail.com>
References: <20091202003503.7737.51579.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: catalin.marinas@gmail.com, git <git@vger.kernel.org>
To: Alex Chiang <achiang@hp.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 08:09:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFjKg-0001bZ-D6
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 08:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbZLBHIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 02:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbZLBHIu
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 02:08:50 -0500
Received: from mail1.space2u.com ([62.20.1.135]:37723 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbZLBHIu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 02:08:50 -0500
Received: from mail-bw0-f227.google.com (mail-bw0-f227.google.com [209.85.218.227])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.3/8.14.3) with ESMTP id nB278npi022215
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Wed, 2 Dec 2009 08:08:49 +0100
Received: by bwz27 with SMTP id 27so4113934bwz.21
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 23:08:55 -0800 (PST)
Received: by 10.204.48.131 with SMTP id r3mr6884562bkf.195.1259737735514; Tue, 
	01 Dec 2009 23:08:55 -0800 (PST)
In-Reply-To: <20091202003503.7737.51579.stgit@bob.kio>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134309>

On Wed, Dec 2, 2009 at 1:46 AM, Alex Chiang <achiang@hp.com> wrote:

> This is v2 of the series that starts teaching stg mail how to
> call git send-email.

Acked-by: Karl Wiberg <kha@treskal.com>

when the CmdException/Exception thing is fixed in the first patch.

-- 
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle
