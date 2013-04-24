From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Highly inconsistent diff UI
Date: Wed, 24 Apr 2013 23:42:50 +0530
Message-ID: <CALkWK0kBenocmFb+3mQpcDj8sPCbWuAmQZ71vM8Ee=m3wjDPCQ@mail.gmail.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <20130424164003.GB4119@elie.Belkin> <7va9ones4p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 20:13:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV4CP-00068M-59
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 20:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756619Ab3DXSNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 14:13:32 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:51599 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756584Ab3DXSNb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 14:13:31 -0400
Received: by mail-ie0-f176.google.com with SMTP id x14so2456480ief.7
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 11:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=I6/RW3l4lvTWtMvhPSp5LZ160vxhQb8xg8fHFz/DY6c=;
        b=biVAhbMf5MqJmUh4iuYbvN0bkYiJajIIDAw+V+pG7GU+gMEosKMEI/8FnLIGMdfOdS
         AVWzW20xVSOdCayJVd4j0aJezii8XGUiYn75JIgqXfVbs718SpcjlWhUgv7ILJ/qWjWK
         rasXPrkJtqZQ/xUIk1tGpZS8/k/GUs9X7l7/EgD4uprLP0Ji3hCWq5iX+dXg2o1qZ/1l
         yLnVuXFj7K9GZGx+nKGQF5XTJqK4PXi0TGeYKzSiaMItr7VH0uvCCbVS97HNV82ZlbE8
         uETybXQUg+iSce8r/r1RHnP95lvKJ3tO/qnrEWzE7joDokVIUHHSZRkOzYjNmscMhfdd
         dfhA==
X-Received: by 10.43.125.199 with SMTP id gt7mr19264553icc.48.1366827210684;
 Wed, 24 Apr 2013 11:13:30 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 11:12:50 -0700 (PDT)
In-Reply-To: <7va9ones4p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222283>

Junio C Hamano wrote:
> And it does not match "git log origin...HEAD"

Exactly my problem.  Inconsistency.
