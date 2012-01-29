From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH V4] git on Mac OS and precomposed unicode
Date: Sun, 29 Jan 2012 13:57:35 +0100
Message-ID: <4F25423F.7080006@web.de>
References: <201201212036.57632.tboegi@web.de> <7vsjj8acmh.fsf@alter.siamese.dyndns.org> <CACsJy8BKQHLdoXfSKsULkWWbWjWEuZgr=bVNKmgCSArvwbf2UA@mail.gmail.com> <4F251FA1.80400@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 29 13:58:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrUKf-0005R7-I1
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 13:58:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890Ab2A2M5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 07:57:54 -0500
Received: from smtp-out11.han.skanova.net ([195.67.226.200]:48718 "EHLO
	smtp-out11.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752477Ab2A2M5j (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2012 07:57:39 -0500
Received: from birne.lan (194.22.188.61) by smtp-out11.han.skanova.net (8.5.133) (authenticated as tboegi@telia.com)
        id 4EFC3D3500AC9A2E; Sun, 29 Jan 2012 13:57:36 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <4F251FA1.80400@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189288>


> I tried that, and found that git-lsfiles.c doesn't use parse_options.
Oops, I shouldn't have written that: git-lsfiles uses parse_options.

Sorry for the noise.
/torsten
