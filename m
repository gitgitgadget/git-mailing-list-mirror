From: Johan Herland <johan@herland.net>
Subject: Re: excerpts from tomorrow's "What's cooking" draft
Date: Wed, 11 Nov 2009 18:07:32 +0100
Message-ID: <200911111807.32835.johan@herland.net>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 18:07:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Gfj-0000u5-La
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 18:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757400AbZKKRHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 12:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756164AbZKKRHo
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 12:07:44 -0500
Received: from smtp.opera.com ([213.236.208.81]:43314 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753918AbZKKRHo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 12:07:44 -0500
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5) with ESMTP id nABH6Wxl021042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 11 Nov 2009 17:06:41 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132675>

On Wednesday 11 November 2009, Junio C Hamano wrote:
> * jh/notes (2009-10-09) 22 commits.
>  - fast-import: Proper notes tree manipulation using the notes API
>  - ...
>  - Notes API: get_commit_notes() -> format_note() + remove the commit
> restriction (merged to 'next' on 2009-11-01 at 948327a)
>  + Add selftests verifying concatenation of multiple notes for the
> same commit + ...
>  + Introduce commit notes
>
> I somehow thought that the later API part was waiting for updates but
> nothing seems to be happening.

Sorry for the silence, I've been out with the flu, and been caught up 
with meatspace issues in general. Will try to send another iteration of 
the later API part in a few days.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
