From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/10] builtin-archive: mark unused prefix
 "unused_prefix"
Date: Tue, 11 Mar 2008 14:33:03 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803111432370.3873@racer.site>
References: <cover.1204453703.git.pclouds@gmail.com> <20080302103446.GA8983@laptop>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1165568721-1205242385=:3873"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 14:34:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ4c7-0008Ul-9P
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 14:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbYCKNdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 09:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbYCKNdA
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 09:33:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:42422 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751242AbYCKNdA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 09:33:00 -0400
Received: (qmail invoked by alias); 11 Mar 2008 13:32:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp020) with SMTP; 11 Mar 2008 14:32:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/14UAi8Rj1ZTxjB2aIs8I3xVrzIEQGvXaiD3YC2M
	zBZlM2Gl5dT82v
X-X-Sender: gene099@racer.site
In-Reply-To: <20080302103446.GA8983@laptop>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76845>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1165568721-1205242385=:3873
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 2 Mar 2008, Nguyễn Thái Ngọc Duy wrote:

> cmd_archive() is registered without RUN_SETUP so its prefix
> will be NULL forever. Let's make that clear.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---

AFAICT this patch is -- like two others -- an independent fix, and should 
be submitted as such.

Ciao,
Dscho
--8323584-1165568721-1205242385=:3873--
