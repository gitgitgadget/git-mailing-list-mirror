From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 00/16] Introduce a tempfile module
Date: Wed, 12 Aug 2015 17:14:57 +0200
Message-ID: <55CB62F1.30403@alum.mit.edu>
References: <cover.1439198011.git.mhagger@alum.mit.edu> <xmqqzj1xpodw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 17:15:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPXkE-0005ky-O1
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 17:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbbHLPPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 11:15:03 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64877 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753788AbbHLPPA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Aug 2015 11:15:00 -0400
X-AuditID: 1207440d-f79136d00000402c-fc-55cb62f37edc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 1A.93.16428.3F26BC55; Wed, 12 Aug 2015 11:14:59 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97D5A.dip0.t-ipconnect.de [79.201.125.90])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7CFEvi4014006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 12 Aug 2015 11:14:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <xmqqzj1xpodw.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsUixO6iqPs56XSowZpt8hZdV7qZLBp6rzBb
	PJl7l9mB2ePhqy52j4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M64/uEWc8FexoqLS2axNTBO
	Yuxi5OSQEDCRaF/WxAZhi0lcuLceyObiEBK4zChxuWsllHOeSeLJ/9WsIFW8ApoS5xofsIPY
	LAKqEqcarzGB2GwCuhKLepqBbA4OUYEgidcvcyHKBSVOznzCAmKLCKhJTGw7BGYzC5hK3Ho4
	E2yxsIClxN5Nx8BsIYE0ifWbNoKt4hSwltjx5DMzRL2exI7rv1ghbHmJ7W/nME9gFJiFZMUs
	JGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrpJebWaKXmlK6iRESurw7GP+vkznE
	KMDBqMTDazDxVKgQa2JZcWXuIUZJDiYlUd6bCadDhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nw
	1oUA5XhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErwrE4EaBYtS01Mr
	0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kGRGl8MjFWQFA/Q3tUg7bzFBYm5QFGI1lOMxhzP
	pl1by8Sx4MfttUxCLHn5ealS4rx7QEoFQEozSvPgFsGS1itGcaC/hXnFgSlMiAeY8ODmvQJa
	xQS0Kl3uFMiqkkSElFQDY9KrWZ1vdjmG97udev/hQ03rxWW2//ZM3L4m+vx5zh33VzSLu09y
	KVRKPzf1X7KC8u+t22ukRJ4Vd+xXOf6ZNcr0zHxO3Sd2HRMiJ27YyVZ94tTmWfGV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275772>

On 08/11/2015 10:21 PM, Junio C Hamano wrote:
> Thanks for a pleasant read.  All looked reasonable.

Thanks for your review!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
